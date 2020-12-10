// use std::path::PathBuf;
extern crate clap;
use clap::{Arg, App, SubCommand};

mod caml;
use crate::caml as caml_lib;

// #[derive(StructOpt)]
// #[structopt(name = "caml", about = "A dynamic CLI tool defined with declarative YAML")]
// enum Caml {
//     #[structopt(name = "hello", about = "Say hello")]
//     Hello,
//     #[structopt(name = "config", about = "Configuration")]
//     Config,
//     #[structopt(name = "init", about = "Initialize a directory for caml")]
//     Init {
//         #[structopt(parse(from_os_str))]
//         /// Directory to initialize (Default: current directory)
//         directory: Option<PathBuf>,
//     }
//     // Reserved: init, help, show?, audit?
// }

// fn main() {
//     let caml = Caml::from_args();

//     if let Caml::Init { ref directory } = caml {
//         caml_lib::config::init(directory);
//     } else {
//         let config = caml_lib::config::load();

//         match caml {
//             Caml::Hello => { caml_lib::command::hello_world() },
//             Caml::Config => { println!("{:?}", config); },
//             // Caml::Init { directory } => { caml_lib::config::init(directory) },
//             _ => {},
//         }
//     }

// }

fn main() {
    // 1. Get the config
    // 2. Structure the config
    // 3. Use config to build subcommands
    // 4. Get matches
    // 5. Handle standard commands
    // 6. Use config to build handlers (execute handler)
    // More
    // Allow ability to pass in config file from command line
    // Add verbosity
    // Allow for rest args
    let _config = caml_lib::config::load();
    let app = App::new("caml")
                          .version("0.1.2")
                          .author("Ian Johnson <tacoda@hey.com>")
                          .about("A dynamic CLI tool defined with declarative YAML")
                          // .arg(Arg::with_name("config")
                          //      .short("c")
                          //      .long("config")
                          //      .value_name("FILE")
                          //      .help("Sets a custom config file")
                          //      .takes_value(true))
                          // .arg(Arg::with_name("INPUT")
                          //      .help("Sets the input file to use")
                          //      .required(true)
                          //      .index(1))
                          // .arg(Arg::with_name("v")
                          //      .short("v")
                          //      .multiple(true)
                          //      .help("Sets the level of verbosity"))
                          .subcommand(SubCommand::with_name("init")
                                      .about("Initialize a directory for caml")
                                      .arg(Arg::with_name("DIRECTORY")
                                          .default_value(".")
                                          .help("Directory to initialize")));
    let matches = app.get_matches();

    // // Gets a value for config if supplied by user, or defaults to "default.conf"
    // let config = matches.value_of("config").unwrap_or("default.conf");
    // println!("Value for config: {}", config);

    // // Calling .unwrap() is safe here because "INPUT" is required (if "INPUT" wasn't
    // // required we could have used an 'if let' to conditionally get the value)
    // println!("Using input file: {}", matches.value_of("INPUT").unwrap());

    // // Vary the output based on how many times the user used the "verbose" flag
    // // (i.e. 'myprog -v -v -v' or 'myprog -vvv' vs 'myprog -v'
    // match matches.occurrences_of("v") {
    //     0 => println!("No verbose info"),
    //     1 => println!("Some verbose info"),
    //     2 => println!("Tons of verbose info"),
    //     3 | _ => println!("Don't be crazy"),
    // }

    // You can handle information about subcommands by requesting their matches by name
    // (as below), requesting just the name used, or both at the same time
    if let Some(matches) = matches.subcommand_matches("init") {
        println!("{:?}", matches.value_of("DIRECTORY").unwrap());
        // if matches.is_present("dir") {
        //     println!("Printing debug info...");
        // } else {
        //     println!("Printing normally...");
        // }
    }

    // more program logic goes here...
}
