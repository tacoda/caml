use std::path::PathBuf;
use structopt::StructOpt;
use serde::{Serialize, Deserialize};

/// A basic example
#[derive(StructOpt, Debug)]
#[structopt(name = "basic")]
struct Opt {
    // A flag, true if used in the command line. Note doc comment will
    // be used for the help message of the flag. The name of the
    // argument will be, by default, based on the name of the field.
    /// Activate debug mode
    #[structopt(short, long)]
    debug: bool,

    // The number of occurrences of the `v/verbose` flag
    /// Verbose mode (-v, -vv, -vvv, etc.)
    #[structopt(short, long, parse(from_occurrences))]
    verbose: u8,

    /// Set speed
    #[structopt(short, long, default_value = "42")]
    speed: f64,

    /// Output file
    #[structopt(short, long, parse(from_os_str))]
    output: PathBuf,

    // the long option will be translated by default to kebab case,
    // i.e. `--nb-cars`.
    /// Number of cars
    #[structopt(short = "c", long)]
    nb_cars: Option<i32>,

    /// admin_level to consider
    #[structopt(short, long)]
    level: Vec<String>,

    /// Files to process
    #[structopt(name = "FILE", parse(from_os_str))]
    files: Vec<PathBuf>,
}

#[derive(Debug, PartialEq, Serialize, Deserialize)]
struct Point {
    x: f64,
    y: f64,
}

fn serialize_and_deserialize_point() -> Result<(), serde_yaml::Error> {
    let point = Point { x: 1.0, y: 2.0 };

    let s = serde_yaml::to_string(&point)?;
    assert_eq!(s, "---\nx: 1.0\ny: 2.0");

    let deserialized_point: Point = serde_yaml::from_str(&s)?;
    assert_eq!(point, deserialized_point);
    Ok(())
}

fn main() {
    let opt = Opt::from_args();
    println!("{:#?}", opt);
    match serialize_and_deserialize_point() {
        Err(_e) => println!("Failure"),
        Ok(_r) => println!("Success"),
    }
}
