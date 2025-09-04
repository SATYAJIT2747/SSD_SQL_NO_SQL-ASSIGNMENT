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
        month: { $month: "$dateObj" },
        day: { $dayOfMonth: "$dateObj" }
      },
      dailyAvg: { $avg: "$temp.avg_c" }
    }
  },
  { $sort: { "_id.city": 1, "_id.month": 1, "_id.day": 1 } }
])
