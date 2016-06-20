
class Message < ApplicationRecord
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros

  # followed by association macros

  belongs_to :from, class_name: "User"

  belongs_to :to, class_name: "User"

  # and validation macros

  # next we have callbacks

  # other macros (like devise's) should be placed after the callbacks
  def self.dialogs_for_user(user_id)
    # dialogs = Message.select('MAX(id) as i').where('from_id = :user_id OR to_id = :user_id', {user_id: user_id}).
    # group('least(to_id, from_id), greatest(to_id, from_id)')
    #
    # Message.joins("INNER JOIN (#{dialogs}) d ON message.id = d.i").order('id desc')
    # FIXME сделать, чтобы бралось всегда последнее сообщение из диалога
    Message.select('DISTINCT ON (from_id) from_id, to_id').where('from_id = :user_id OR to_id = :user_id', {user_id: user_id}).order('from_id, to_id, created_at desc').select('*').all
  end

   # finally, scopes
end
