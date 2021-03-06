#   Copyright 2013 Matt Farmer
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
Apricot = require('apricot').Apricot

voteListUri = "http://www.legis.ga.gov/Legislation/en-US/VoteList.aspx"
targetUri = (chamber, session) ->
  voteListUri + "?Chamber=" + chamber + "&Session=" + session

module.exports = (jobs) ->
  jobs.process 'scrape vote list', (job, done) ->
    Apricot.open targetUri(job.chamber, job.session), (err, doc) ->
      doc.find(".mainContent a:not(.ms-sitemapdirectional)").each (elem) ->
        uriOfVote = elem.attr("href")

        # TODO: Check to see if the vote has been logged.
        console.log(uriOfVote)

      done()
