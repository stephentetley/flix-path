//
// Copyright 2026 Stephen Tetley
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//




pub mod Interop.Path {
    
    use EffectExtras.Fail.Fail
    use JavaInterop.AdaptorChecked

    import java.nio.file.{Path => JPath}
    import java.lang.{Exception => JException}
    import java.util.{Iterator => JIterator}

    pub type alias Path = String

    pub def concat(p1: Path, p2: Path): Path \ Fail = 
        AdaptorChecked.of(() -> unsafe IO { JPath.of(p1, p2).toString() })
        

    pub def startsWith(s: {prefix = String}, p: Path): Bool \ Fail = 
        AdaptorChecked.guarded(() -> {
            let p1 = unsafe IO { JPath.of(p) };
            unsafe IO { p1.startsWith(s#prefix) }
        })

    pub def endsWith(s: {suffix = String}, p: Path): Bool \ Fail = 
        AdaptorChecked.guarded(() -> {
            let p1 = unsafe IO { JPath.of(p) };
            unsafe IO { p1.endsWith(s#suffix) }
        })


    pub def getExtension(p: Path): String \ Fail = 
        let s1 = getFileName(p);
        String.splitOn(substr = ".", s1) |> List.last |> Fail.fromOption

    pub def swapExtension(ext: String, p: Path): Path \ Fail = 
        let dirpath = getParent(p);
        let base = getBaseName(p);
        concat(dirpath, base ++ "." ++ ext)

    pub def mapExtension(f: String -> String \ ef, p: Path): Path \ ef + Fail = 
        let dirpath = getParent(p);
        let base = getBaseName(p);
        let ext = getExtension(p);
        concat(dirpath, base ++ "." ++ f(ext))



    pub def getFileName(p: Path): String \ Fail = 
        AdaptorChecked.guarded(() -> {
            let p1 = unsafe IO { JPath.of(p) };
            unsafe IO { p1.getFileName().toString() }
        })

    pub def getBaseName(p: Path): String \ Fail = 
        let s = getFileName(p);
        let i = String.indexOfRight(substr = ".", s) |> Fail.fromOption;
        String.takeLeft(i, s)
    
    pub def swapBaseName(baseName: String, p: Path): Path \ Fail = 
        let dirpath = getParent(p); 
        let ext = getExtension(p);
        concat(dirpath, baseName ++ "." ++ ext)

    pub def mapBaseName(f: String -> String \ ef, p: Path): Path \ ef + Fail = 
        let dirpath = getParent(p);
        let base = getBaseName(p);
        let ext = getExtension(p);
        concat(dirpath, f(base) ++ "." ++ ext)

    pub def getParent(p: Path): String \ Fail = 
        AdaptorChecked.guarded(() -> {
            let p1 = unsafe IO { JPath.of(p) };
            unsafe IO { p1.getParent().toString() }
        })

    pub def getRoot(p: Path): String \ Fail = 
        AdaptorChecked.guarded(() -> {
            let p1 = unsafe IO { JPath.of(p) };
            unsafe IO { p1.getRoot().toString() }
        })

    pub def getNameCount(p: Path): Int32 = 
        let p1 = unsafe IO { JPath.of(p) };
        unsafe IO { p1.getNameCount() }


    pub def isAbsolute(p: Path): Bool \ Fail = 
        AdaptorChecked.guarded(() -> {
            let p1 = unsafe IO { JPath.of(p) };
            unsafe IO { p1.isAbsolute() }
        })

    pub def normalize(p: Path): Path \ Fail = 
        AdaptorChecked.guarded(() -> {
            let p1 = unsafe IO { JPath.of(p) };
            unsafe IO { p1.normalize().toString() }
        })

    pub def nth(i: Int32, p: Path): String \ Fail = 
        AdaptorChecked.guarded(() -> {
            let p1 = unsafe IO { JPath.of(p) };
            unsafe IO { p1.getName(i).toString() }
        })

    pub def slice(start: { start = Int32 }, end: { end = Int32 }, p: Path): Path \ Fail =
        AdaptorChecked.guarded(() -> {
            let p1 = unsafe IO { JPath.of(p) };
            unsafe IO { p1.subpath(start#start, end#end).toString() }
        })

    pub def resolve(other: { other = String }, p: Path): Path \ Fail =
        AdaptorChecked.guarded(() -> {
            let p1 = unsafe IO { JPath.of(p) };
            unsafe IO { p1.resolve(other#other).toString() }
        })

    pub def resolveSibling(other: { other = String }, p: Path): Path \ Fail =
        AdaptorChecked.guarded(() -> {
            let p1 = unsafe IO { JPath.of(p) };
            unsafe IO { p1.resolveSibling(other#other).toString() }
        })

    pub def relativize(other: { other = String }, p: Path): Path \ Fail =
        AdaptorChecked.guarded(() -> {
            let p1 = unsafe IO { JPath.of(p) };
            let other1 = unsafe IO { JPath.of(other#other) };
            unsafe IO { p1.relativize(other1).toString() }
        })

    pub def iterator(rc: Region[r], p: Path): Iterator[String, r, r] = 
        def toStr(jp: JPath) = unsafe IO { jp.toString() };
        let p1 = unsafe IO { JPath.of(p) };
        let jiter: JIterator[JPath] = unsafe IO { p1.iterator() };
        let iterPath: Iterator[JPath, r, r] = Adaptor.fromIterator(rc, (Proxy.Proxy: Proxy[JPath]), jiter);
        let ans = Iterator.map(toStr, iterPath);
        ans

}
