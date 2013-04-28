class AddSpeakerIdIndexToOccurences < ActiveRecord::Migration
  def change
  	add_index :occurences, [:phrase_id, :speaker_id]
  end
end
