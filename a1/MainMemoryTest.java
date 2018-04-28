package arch.sm213.machine.student;


import arch.sm213.machine.student.MainMemory;
import machine.AbstractMainMemory;
import org.junit.Test;
import org.junit.Before;
import org.omg.CosNaming.NamingContextExtPackage.InvalidAddress;

import static org.junit.Assert.assertEquals;
import static org.junit.jupiter.api.Assertions.fail;

public class MainMemoryTest {
    MainMemory mainMemory;


    @Test
    public void testIntToByte(){
        mainMemory = new MainMemory(8);
        byte[] b = mainMemory.integerToBytes(256);

        assertEquals(0, b[0]);
        assertEquals(0,b[1]);
        assertEquals(b[2], 1);
        assertEquals(b[3], 0);

        byte[] byte1 = mainMemory.integerToBytes(-5555);
        assertEquals((byte)0xFF, byte1[0]);
        assertEquals((byte)0xFF, byte1[1]);
        assertEquals((byte)0xEA, byte1[2]);
        assertEquals((byte)0x4D, byte1[3]);

        byte[] byte2 = mainMemory.integerToBytes(2147483647);
        assertEquals((byte)0x7F, byte2[0]);
        assertEquals((byte)0xFF, byte2[1]);
        assertEquals((byte)0xFF, byte2[2]);
        assertEquals((byte)0xFF, byte2[3]);
    }

    @Test
    public void testIsAccessAligned(){
        mainMemory = new MainMemory(8);
        assertEquals(false, mainMemory.isAccessAligned(3, 5));
        assertEquals(true, mainMemory.isAccessAligned(0, 3));
        assertEquals(true, mainMemory.isAccessAligned(4,4 ));
    }

    @Test
    public void testBytesToInteger(){
        mainMemory = new MainMemory(8);
        byte a = (byte)0xFF;
        byte b = (byte)0x10;
        byte c = (byte)0x10;
        byte d = (byte)0x01;
        assertEquals(-15724543,mainMemory.bytesToInteger(a,b,c,d));
    }

    @Test
    public void testSetter(){
        mainMemory = new MainMemory(8);
        byte[] b = {(byte)0xFF, (byte)0x12, (byte)0xFF, (byte)0x12};
        try {
            mainMemory.set(0, b);
            byte[] compare = mainMemory.get(0, 4);
            assertEquals(compare[0], b[0]);
            assertEquals(compare[1], b[1]);
            assertEquals(compare[2], b[2]);
            assertEquals(compare[3], b[3]);
        }catch(AbstractMainMemory.InvalidAddressException e){
            fail("Should not throw exception");
        }


    }
}
