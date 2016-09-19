require 'PageableAR'

angular.module 'starter.model', ['PageableAR']

	.factory 'resources', (pageableAR) ->

		class Record extends pageableAR.Model
			$idAttribute: 'id'
			
			$urlRoot: "api/record"

		class RecordList extends pageableAR.PageableCollection
			model: Record
			
			$urlRoot: "api/record"
													
		Record:		Record
		RecordList:	RecordList