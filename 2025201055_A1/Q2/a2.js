db.temperatures.aggregate([
  {
    $addFields: {
      dateObj: { $dateFromString: { dateString: "$date" } }
    }
  },
  {
    $group: {
      _id: {
        city: "$city",
        year: { $year: "$dateObj" },
        month: { $month: "$dateObj" }
      },
      monthlyAvg: { $avg: "$temp.avg_c" }
    }
  },
  { $sort: { "_id.city": 1, "_id.month": 1 } }
])
