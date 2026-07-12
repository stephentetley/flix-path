
pub mod TestPath {

    use Interop.Path.{runPath, getName}

    @Test
    def test01(): Unit \ Assert + IO = 
        let p = "../../lib/libBlank.o";
        let name = runPath(p, _ -> getName(0));
        println(name);
        Assert.assertEq(expected = "..", name)
    
    @Test
    def test02(): Unit \ Assert + IO = 
        let p = "../../lib/libBlank.o";
        run {
            let name = getName(2);
            println(name);
            Assert.assertEq(expected = "lib", name)
        } with Interop.Path.runPath(p)

}

