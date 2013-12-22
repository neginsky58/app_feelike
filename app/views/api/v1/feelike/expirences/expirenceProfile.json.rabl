object @responseObject => :response
extends 'api/v1/base/index'
child :objectData => :data do |response|
	attributes :id,:is_follow,:asset, :name,:totalFollowers,:totalParticipants, :totalMusic,:totalBooks,:totalRests,:totalHangout,:totalMusic ,:totalImages,:user,:items,:total
end