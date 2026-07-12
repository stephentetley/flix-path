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

    pub def getExtension(s: Path): Option[String] = 
        getFileName(s) 
            |> Option.flatMap(s1 -> String.splitOn(substr = ".", s1) |> List.last)


    pub def getFileName(s: Path): Option[String] = 
        try {
            let p = unsafe IO { JPath.of(s) };
            let name = unsafe IO { p.getFileName().toString() };
            if (Object.isNull(name)) None else Some(name)
        } catch  {
            case _ : JException => None
        }


    pub def isAbsolute(s: Path): Bool = 
        try {
            let p = unsafe IO { JPath.of(s) };
            unsafe IO { p.isAbsolute() }
        } catch {
            case _ : JException => false
        }

    pub def nth(i: Int32, s: Path): Option[String] = 
        try {
            let p = unsafe IO { JPath.of(s) };
            let name = unsafe IO { p.getName(i).toString() };
            Some(name)
        } catch  {
            case _ : JException => None
        }


}
