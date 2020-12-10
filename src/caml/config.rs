use serde::{Serialize, Deserialize};

pub fn load() {
    match serialize_and_deserialize_point() {
        Err(_e) => println!("Point serialize failed"),
        Ok(_r) => println!("Point serialize succeeded"),
    }
}

fn find_config() {
    //
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
