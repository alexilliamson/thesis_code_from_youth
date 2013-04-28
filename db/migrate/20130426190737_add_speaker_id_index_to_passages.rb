class AddSpeakerIdIndexToPassages < ActiveRecord::Migration
  def change
  	add_index :passages, :speaker_id
  end
end
