
pub mod TestPath {

    use ee::EffectExtras.Fail
    use Interop.Path
    use Interop.Path.{nth, swapExtension, normalize, getFileName, getExtension, getBaseName}

    @Test
    def newPath01(): Unit \ Assert = 
        let count = run { 
            let p = Path.newPath("../../lib/libBlank.o", List#{});
            Path.getNameCount(p)
        } with Fail.runWithOption;
        Assert.assertEq(expected = Some(4), count)

    @Test
    def newPath02(): Unit \ Assert = 
        let count = run { 
            let p = Path.newPath("../../lib", List#{"libBlank.o"});
            Path.getNameCount(p)
        } with Fail.runWithOption;
        Assert.assertEq(expected = Some(4), count)

    @Test
    def newPath03(): Unit \ Assert = 
        let count = run { 
            let p = Path.newPath("../..", List#{"lib", "libBlank.o"});
            Path.getNameCount(p)
        } with Fail.runWithOption;
        Assert.assertEq(expected = Some(4), count)

    @Test
    def newPath04(): Unit \ Assert = 
        let count = run { 
            let p = Path.newPath("..", List#{"..", "lib", "libBlank.o"});
            Path.getNameCount(p)
        } with Fail.runWithOption;
        Assert.assertEq(expected = Some(4), count)



    @Test
    def nth01(): Unit \ Assert = 
        let name = run { 
            let p = "../../lib/libBlank.o";
            nth(0, p)
        } with Fail.runWithOption;
        Assert.assertEq(expected = Some(".."), name)
    
    @Test
    def nth02(): Unit \ Assert = 
        let name = run { 
            let p = "../../lib/libBlank.o";
            nth(2, p)
        } with Fail.runWithOption;
        Assert.assertEq(expected = Some("lib"), name)

    @Test
    def getFileName01(): Unit \ Assert = 
        let name = run {
            let p = "/home/Users/Stephen/Documents/cv.pdf";
            getFileName(p)
        } with Fail.runWithOption;
        Assert.assertEq(expected = Some("cv.pdf"), name)

    @Test
    def getExtension01(): Unit \ Assert = 
        let ext = run {
            let p = "/home/users/Stephen/Documents/cv.pdf";
            getExtension(p)
        } with Fail.runWithOption;
        Assert.assertEq(expected = Some("pdf"), ext)

    @Test
    def getExtension02(): Unit \ Assert = 
        let ext = run {
            let p = "C:\\Programs\\java\\bin\\java.exe";
            getExtension(p)
        } with Fail.runWithOption;
        Assert.assertEq(expected = Some("exe"), ext)


    @Test
    def swapExtension01(): Unit \ Assert = 
        let ans = run {
            let p = "/home/users/Stephen/Documents/cv.ps";
            swapExtension("pdf", p)
        } with Fail.runWithOption;
        Assert.assertEq(expected = Some("/home/users/Stephen/Documents/cv.pdf"), ans)


    @Test
    def getBaseName01(): Unit \ Assert = 
        let name = run {
            let p = "/home/users/Stephen/Documents/cv.pdf";
            getBaseName(p)
        } with Fail.runWithOption;
        Assert.assertEq(expected = Some("cv"), name)
     

    @Test
    def iterator01(): Unit \ Assert = region rc {
        let p = "/home/users/Stephen/Documents/cv.pdf";
        let iter = Interop.Path.iterator(rc, p);
        let longest = Ref.fresh(rc, "");
        Iterator.forEach(
            s -> { 
                let x = Ref.get(longest); 
                if (String.length(s) > String.length(x)) Ref.put(s, longest) else ()
                },
            iter);
        Assert.assertEq(expected = "Documents", Ref.get(longest))
    }


}

