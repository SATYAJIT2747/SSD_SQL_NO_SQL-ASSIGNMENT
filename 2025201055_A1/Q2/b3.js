db.temperatures.aggregate([
  { $match: { city: "Mumbai" } }, 
  { $addFields: { dateObj: { $dateFromString: { dateString: "$date" } } } }, 
  { $sort: { dateObj: 1 } }, 
  {
    $setWindowFields: {
      partitionBy: "$city",
      sortBy: { dateObj: 1 },
      output: {
        movingAvg7: {
          $avg: "$temp.avg_c",
          window: { range: [-6, 0], unit: "day" }
        }
      }
    }
  },
  { $project: { _id: 0, city: 1, date: 1, avgTemp: "$temp.avg_c", movingAvg7: 1 } }
])
