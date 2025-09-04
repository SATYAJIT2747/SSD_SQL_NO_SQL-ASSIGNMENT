db.temperatures.aggregate([
  {
    $group: {
      _id: "$date", 
      nationwideAvg: { $avg: "$temp.avg_c" }
    }
  },
  {
    $facet: {
      hottest: [ { $sort: { nationwideAvg: -1 } }, { $limit: 5 } ],
      coldest: [ { $sort: { nationwideAvg: 1 } }, { $limit: 5 } ]
    }
  }
])
