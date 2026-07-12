
pub mod TestPath {

    use Interop.Path.{nth}

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

}

