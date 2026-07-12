
pub mod TestPath {

    use Interop.Path.{nth, getExtension}

    @Test
    def nth01(): Unit \ Assert + IO = 
        let p = "../../lib/libBlank.o";
        let name = nth(0, p);
        println(name);
        Assert.assertEq(expected = Some(".."), name)
    
    @Test
    def nth02(): Unit \ Assert + IO = 
        let p = "../../lib/libBlank.o";
        let name = nth(2, p);
        println(name);
        Assert.assertEq(expected = Some("lib"), name)


    @Test
    def getExtension01(): Unit \ Assert + IO = 
        let p = "C:\\Users\\Stephen\\Documents\\cv.pdf";
        let ext = getExtension(p);
        println(ext);
        Assert.assertEq(expected = Some("pdf"), ext)

     
}

