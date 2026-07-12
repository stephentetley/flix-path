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

    pub eff Path {
        def reify(): JPath
    }

    pub def handle(s: String, f: a -> b \ ef): a -> b \ (ef - Path) = x -> {
        let path = unsafe IO { JPath.of(s) };
        run {
            f(x)
        } with handler Path {
            
            def reify(k) = k(path)
        }
    }


    pub def runPath(s: String, f: Unit -> a \ ef): a \ (ef - Path) = handle(s, f)()


    pub def getName(i: Int32): String \ Path = 
        let p = Path.reify();
        unsafe IO { p.getName(i).toString() }

}
