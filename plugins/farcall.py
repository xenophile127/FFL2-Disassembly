from annotation.annotation import annotation
from block.base import Block
from block.code import CodeBlock
from romInfo import RomInfo

@annotation
def FFLFarcall(memory, addr):
    label = memory.getLabel(addr)
    assert label.startswith("execute")
    macroname = label[7:].lower()
    FarcallCodeBlock(memory, addr, macroname)
    # Note, ugly hack when a farcall to bank 0 is done with bank 1 active.
    RomInfo.macros[macroname] = f"call {label}\n dw \\1\n db BANK(\\1) + (BANK(\\1) == 0)"

@annotation(priority=200)
def FFLFarcall2(memory, addr):
    FFLFarcall(memory, addr)


class FarcallCodeBlock(CodeBlock):
    def __init__(self, memory, addr, macroname):
        super().__init__(memory, addr)
        self.__macroname = macroname

    def onCall(self, from_memory, from_address, next_addr):
        assert from_memory.byte(from_address) == 0xCD # CALL ...
        block = from_memory[from_address]
        block.resize(len(block) - 3, allow_shrink=True)

        FarcallBlock(from_memory, from_address, self.__macroname)
        CodeBlock(from_memory, next_addr + 3)


class FarcallBlock(Block):
    def __init__(self, memory, address, macroname):
        super().__init__(memory, address, size=6)

        self.__target_address = memory.word(address + 3)
        self.__bank = memory.byte(address + 5)
        self.__macroname = macroname

        try:
            target_memory = RomInfo.memoryAt(self.__target_address, RomInfo.romBank(self.__bank))
        except IndexError:
            return
        target_block = target_memory[self.__target_address]
        if target_block is None:
            target_block = CodeBlock(target_memory, self.__target_address)
        target_block.addAutoLabel(self.__target_address, address, "call")

    def export(self, file):
        try:
            target_memory = RomInfo.memoryAt(self.__target_address, RomInfo.romBank(self.__bank))
        except IndexError:
            print("Farcall export error")
            file.dataLine(6)
            return
        label = target_memory.getLabel(self.__target_address)
        if not label:
            print("Farcall export error")
            file.dataLine(6)
            return
        file.asmLine(6, self.__macroname, str(label))
