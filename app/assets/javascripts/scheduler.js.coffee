
window.eventDateCollection = new MeetupApi.EventDateCollection App.eventDates
eventDateCollection.each (eventDate) ->
  console.log eventDate.get('possible_dates')

new MeetupApi.SchedulerView
  rowsNumber: App.rowsNumber
  columnsNumber: App.columnsNumber
