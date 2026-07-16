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

    
    import java.nio.file.{Path => JPath}
    import java.lang.{Exception => JException}

    pub type alias Path = String


    pub def concat(p1: Path, p2: Path): Option[Path] = 
        try {
            let ans = unsafe IO { JPath.of(p1, p2).toString() };
            Some(ans)
        } catch {
            case _ : JException => None
        }
        

    pub def startsWith(s: {prefix = String}, p: Path): Bool = 
        try {
            let p1 = unsafe IO { JPath.of(p) };
            unsafe IO { p1.startsWith(s#prefix) }
        } catch  {
            case _ : JException => false
        }

    pub def endsWith(s: {suffix = String}, p: Path): Bool = 
        try {
            let p1 = unsafe IO { JPath.of(p) };
            unsafe IO { p1.endsWith(s#suffix) }
        } catch  {
            case _ : JException => false
        }


    pub def getExtension(p: Path): Option[String] = 
        getFileName(p) 
            |> Option.flatMap(s1 -> String.splitOn(substr = ".", s1) |> List.last)

    pub def swapExtension(ext: String, p: Path): Option[Path] = 
        forM(dirpath <- getParent(p);
                base <- getBaseName(p);
                p1 <- concat(dirpath, base ++ "." ++ ext))
            yield(p1)

    pub def mapExtension(f: String -> String \ ef, p: Path): Option[Path] \ ef = 
        forM(dirpath <- getParent(p);
                base <- getBaseName(p);
                ext <- getExtension(p);
                p1 <- concat(dirpath, base ++ "." ++ f(ext)))
            yield(p1)



    pub def getFileName(p: Path): Option[String] = 
        try {
            let p1 = unsafe IO { JPath.of(p) };
            let name = unsafe IO { p1.getFileName().toString() };
            if (Object.isNull(name)) None else Some(name)
        } catch  {
            case _ : JException => None
        }

    pub def getBaseName(p: Path): Option[String] = 
        forM(s <- getFileName(p); i <- String.indexOfRight(substr = ".", s))
            yield String.takeLeft(i, s)
    
    pub def swapBaseName(baseName: String, p: Path): Option[Path] = 
        forM(dirpath <- getParent(p);
                ext <- getExtension(p);
                p1 <- concat(dirpath, baseName ++ "." ++ ext))
            yield(p1)

    pub def mapBaseName(f: String -> String \ ef, p: Path): Option[Path] \ ef = 
        forM(dirpath <- getParent(p);
                base <- getBaseName(p);
                ext <- getExtension(p);
                p1 <- concat(dirpath, f(base) ++ "." ++ ext))
            yield(p1)

    pub def getParent(p: Path): Option[String] = 
        try {
            let p1 = unsafe IO { JPath.of(p) };
            let name = unsafe IO { p1.getParent().toString() };
            if (Object.isNull(name)) None else Some(name)
        } catch  {
            case _ : JException => None
        }

    pub def getRoot(p: Path): Option[String] = 
        try {
            let p1 = unsafe IO { JPath.of(p) };
            let name = unsafe IO { p1.getRoot().toString() };
            if (Object.isNull(name)) None else Some(name)
        } catch  {
            case _ : JException => None
        }

    pub def getNameCount(p: Path): Int32 = 
        let p1 = unsafe IO { JPath.of(p) };
        unsafe IO { p1.getNameCount() }



    pub def isAbsolute(p: Path): Bool = 
        try {
            let p1 = unsafe IO { JPath.of(p) };
            unsafe IO { p1.isAbsolute() }
        } catch {
            case _ : JException => false
        }

    pub def normalize(p: Path): Path = 
        try {
            let p1 = unsafe IO { JPath.of(p) };
            unsafe IO { p1.normalize().toString() }
        } catch  {
            case _ : JException => ""
        }

    pub def nth(i: Int32, p: Path): Option[String] = 
        try {
            let p1 = unsafe IO { JPath.of(p) };
            let name = unsafe IO { p1.getName(i).toString() };
            Some(name)
        } catch  {
            case _ : JException => None
        }

    pub def slice(start: { start = Int32 }, end: { end = Int32 }, p: Path): Option[Path] =
        try {
            let p1 = unsafe IO { JPath.of(p) };
            let name = unsafe IO { p1.subpath(start#start, end#end).toString() };
            if (Object.isNull(name)) None else Some(name)
        } catch  {
            case _ : JException => None
        }

    pub def resolve(other: { other = String }, p: Path): Option[Path] =
        try {
            let p1 = unsafe IO { JPath.of(p) };
            let name = unsafe IO { p1.resolve(other#other).toString() };
            if (Object.isNull(name)) None else Some(name)
        } catch  {
            case _ : JException => None
        }

    pub def resolveSibling(other: { other = String }, p: Path): Option[Path] =
        try {
            let p1 = unsafe IO { JPath.of(p) };
            let name = unsafe IO { p1.resolveSibling(other#other).toString() };
            if (Object.isNull(name)) None else Some(name)
        } catch  {
            case _ : JException => None
        }

    pub def relativize(other: { other = String }, p: Path): Option[Path] =
        try {
            let p1 = unsafe IO { JPath.of(p) };
            let other1 = unsafe IO { JPath.of(other#other) };
            let name = unsafe IO { p1.relativize(other1).toString() };
            if (Object.isNull(name)) None else Some(name)
        } catch  {
            case _ : JException => None
        }

    // TODO iterator

}
