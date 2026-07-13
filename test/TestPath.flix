
pub mod TestPath {

    use Interop.Path.{nth, swapExtension, normalize, getFileName, getExtension, getBaseName}

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
    def getFileName01(): Unit \ Assert + IO = 
        let p = "/home/Users/Stephen/Documents/cv.pdf";
        let ext = getFileName(p);
        println(ext);
        Assert.assertEq(expected = Some("cv.pdf"), ext)

    @Test
    def getExtension01(): Unit \ Assert + IO = 
        let p = "/home/users/Stephen/Documents/cv.pdf";
        let ext = getExtension(p);
        println(ext);
        Assert.assertEq(expected = Some("pdf"), ext)

    @Test
    def getExtension02(): Unit \ Assert + IO = 
        let p = "C:\\Programs\\java\\bin\\java.exe";
        let ext = getExtension(p);
        println(ext);
        Assert.assertEq(expected = Some("exe"), ext)


    @Test
    def swapExtension01(): Unit \ Assert + IO = 
        let p = "/home/users/Stephen/Documents/cv.ps";
        let ans = swapExtension("pdf", p);
        println(ans);
        Assert.assertEq(expected = Some("/home/users/Stephen/Documents/cv.pdf"), ans)


    @Test
    def getBaseName01(): Unit \ Assert + IO = 
        let p = "/home/users/Stephen/Documents/cv.pdf";
        let ext = getBaseName(p);
        println(ext);
        Assert.assertEq(expected = Some("cv"), ext)
     
}

