use std::path::PathBuf;
use structopt::StructOpt;

mod caml;
use crate::caml as caml_lib;

macro_rules! subcommand
{
    ( $( $x:expr ),* ) => {
        {
            let mut result = 0.0;
            $(
                result += $x as f64;
            )*
            result as i64
        }
    };
}

macro_rules! dispatcher
{
    ( $( $x:expr ),* ) => {
        {
            let mut result = 0.0;
            $(
                result += $x as f64;
            )*
            result as i64
        }
    };
}

#[derive(StructOpt)]
#[structopt(name = "caml", about = "A dynamic CLI tool defined with declarative YAML")]
enum Caml {
    #[structopt(name = "hello", about = "Say hello")]
    Hello,
    #[structopt(name = "config", about = "Configuration")]
    Config,
    #[structopt(name = "init", about = "Initialize a directory for caml")]
    Init {
        #[structopt(parse(from_os_str))]
        /// Directory to initialize (Default: current directory)
        directory: Option<PathBuf>,
    }
    // Reserved: init, help, show?, audit?
}

fn main() {
    let caml = Caml::from_args();

    if let Caml::Init { ref directory } = caml {
        caml_lib::config::init(directory);
    } else {
        let config = caml_lib::config::load();

        match caml {
            Caml::Hello => { caml_lib::command::hello_world() },
            Caml::Config => { println!("{:?}", config); },
            // Caml::Init { directory } => { caml_lib::config::init(directory) },
            _ => {},
        }
    }

}
