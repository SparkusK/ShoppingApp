App.analytics = App.cable.subscriptions.create "AnalyticsChannel",
  connected: ->
    loadAnalytics();
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    loadAnalytics();
    # Called when there's incoming data on the websocket for this channel


@loadAnalytics = () ->
  client = new Keen({
    projectId: "59ecbf7bc9e77c0001aedd09",
    readKey: "B0CFF1AE1652BCBFC5EAD20130B22D80E71EEB757BF3B1D8F41D011B5CC69D566EC0C71B1DA86CFFDDA90F485908CCC78473345A4F58C326E5A09FCB52D9D96F90CFF4A1C1C79F4F7451AFEF6C1525299870DADACC754963A17C01681B9AEA0C"
  });
  chartHouseholdsCreated = new Keen.Dataviz()
    .el("#households_created_chart")
    .height(240)
    .title("Households Created")
    .type("metric")
    .prepare();
  client.query("count", {
    event_collection: "household_events",
    timeframe: "this_14_days",
    timezone: "UTC"
  }).then( (res) ->
    chartHouseholdsCreated.data(res).render()
    return
  ).catch( (err) ->
    chartHouseholdsCreated.message(err.message)
    return
  )
  chartTopItems = new Keen.Dataviz()
    .el("#chart_top_items")
    .height(240)
    .title("Top occurring items across households")
    .type("piechart")
    .prepare();
  client.query("count", {
    event_collection: "activation",
    group_by: ["description"],
    timeframe: "this_14_days",
    timezone: "UTC"
  }).then( (res) ->
    chartTopItems.data(res).render()
    return
  ).catch( (err) ->
    chartTopItems.message(err.message)
    return
  )
  chartTotalItemsPrice = new Keen.Dataviz()
    .el("#total_items_price")
    .height(240)
    .title("Total Aggregated Prices for All Items")
    .type("metric")
    .chartOptions({prefix: "R"})
    .prepare();
  $.ajax 'chart_total_items_price/',
    type: 'GET'
    dataType: 'json'
    json: true
  .success( (res) ->
    chartTotalItemsPrice.data(res).render()
    return
  )
  chartTotalUsers = new Keen.Dataviz()
    .el("#total_users")
    .height(240)
    .title("Amount of Users")
    .type("metric")
    .colors(['green'])
    .prepare();
  $.ajax 'chart_user_amount/',
    type: 'GET'
    dataType: 'json'
    json: true
  .success( (res) ->
    chartTotalUsers.data(res).render()
    return
  )
  chartTopTen = new Keen.Dataviz()
    .el("#top_ten_items")
    .height(240)
    .title("Most Costly Items")
    .type("areachart")
    .prepare();
  $.ajax 'chart_top_ten_items/',
    type: 'GET'
    dataType: 'json'
    json: true
  .success( (res) ->
    chartTopTen.data(res).render()
    return
  )
  return
