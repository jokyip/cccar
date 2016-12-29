require 'PageableAR'

angular.module 'starter.model', ['PageableAR']

	.factory 'resources', (pageableAR) ->

		class Record extends pageableAR.Model
			$idAttribute: 'id'
			
			$urlRoot: "api/record"

		class RecordList extends pageableAR.PageableCollection
			model: Record
			
			$urlRoot: "api/record"
			
		class History extends pageableAR.Model
			$idAttribute: 'id'
			
			$urlRoot: "api/history"

		class HistoryList extends pageableAR.PageableCollection
			model: History
			
			$urlRoot: "api/history"
													
		Record:		Record
		RecordList:	RecordList
		History:	History
		HistoryList:	HistoryList