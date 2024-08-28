const url = process.argv.slice(2)[0]
const response = await (await fetch(url)).json()
const latestSuccessTimestamp = response.events.find(a => !a.body.error)?.timestamp
if (!latestSuccessTimestamp) throw 'no latest successful events'
const now = new Date()
console.log(`is ${latestSuccessTimestamp} more than 12 hours behind ${now.toISOString()}?`)
const isBehind = (now.getTime() - 12*60*60*1000) > new Date(latestSuccessTimestamp).getTime()
console.log(isBehind ? 'yes' : 'no')
if (isBehind) throw 'more than 12 hours behind'
