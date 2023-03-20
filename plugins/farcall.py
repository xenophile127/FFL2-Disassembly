from annotation.annotation import annotation
from block.base import Block
from block.code import CodeBlock
from romInfo import RomInfo

@annotation
def FFLFarcall(memory, addr):
    FarcallCodeBlock(memory, addr)

class SdccFarcallCodeBlock(CodeBlock):
    def onCall(self, from_memory, from_address, next_addr):
        FarcallInfoBlock(from_memory, next_addr)
        CodeBlock(from_memory, next_addr + 3)

class FarcallInfoBlock(Block):
    def __init__(self, memory, address):
        super().__init__(memory, address, size=4)

        self.__target_address = memory.word(address)
        self.__bank = memory.byte(address + 2)

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
            file.dataLine(3)
            return
        label = target_memory.getLabel(self.__target_address)
        if not label:
            file.dataLine(3)
            return
        file.asmLine(2, "dw", str(label), is_data=True)
        file.asmLine(1, "db", f"BANK({label})", is_data=True)
