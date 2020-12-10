// use std::path::PathBuf;
use structopt::StructOpt;
// use serde::{Serialize, Deserialize};

mod caml;
use crate::caml as caml_lib;

#[derive(StructOpt)]
#[structopt(name = "caml", about = "A dynamic CLI tool defined with declarative YAML")]
enum Caml {
    #[structopt(name = "hello")]
    Hello,
}

fn main() {
    let caml = Caml::from_args();

    match caml {
        Caml::Hello => { caml_lib::command::hello_world() },
    }
}
