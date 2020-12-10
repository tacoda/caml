use std::path::PathBuf;
use serde::{Serialize, Deserialize};

pub fn load() -> Result<Point, serde_yaml::Error> {
    let s = "---\nx: 1.0\ny: 2.0";
    let point: Point = serde_yaml::from_str(&s)?;
    Ok(point)
}

pub fn init(directory: &Option<PathBuf>) {
    match directory {
        Some(dir) => { println!("Init in the {:?} directory.", dir); },
        None => { println!("Init in the current directory!"); },
    }
}

// fn find_config() {
//     //
// }

#[derive(Debug, PartialEq, Serialize, Deserialize)]
pub struct Point {
    x: f64,
    y: f64,
}

// fn serialize_and_deserialize_point() -> Result<(), serde_yaml::Error> {
//     let point = Point { x: 1.0, y: 2.0 };

//     let s = serde_yaml::to_string(&point)?;
//     assert_eq!(s, "---\nx: 1.0\ny: 2.0");

//     let deserialized_point: Point = serde_yaml::from_str(&s)?;
//     assert_eq!(point, deserialized_point);
//     Ok(())
// }

// use std::fs::File;
// use std::io::prelude::*;

// fn write_file() -> std::io::Result<()> {
//     let mut file = File::create("foo.txt")?;
//     file.write_all(b"Hello, world!")?;
//     Ok(())
// }
