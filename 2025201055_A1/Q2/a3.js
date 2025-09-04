db.temperatures.aggregate([
  {
    $addFields: { dateObj: { $dateFromString: { dateString: "$date" } } }
  },
  { $match: { "dateObj": { $gte: ISODate("2025-01-01"), $lte: ISODate("2025-06-30") } } },
  {
    $group: {
      _id: "$city",
      avgTemp: { $avg: "$temp.avg_c" }
    }
  },
  { $sort: { avgTemp: -1 } },
  {
    $facet: {
      hottest: [ { $limit: 1 } ],
      coldest: [ { $sort: { avgTemp: 1 } }, { $limit: 1 } ]
    }
  }
])
