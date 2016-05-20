<% module_namespacing do -%>
class <%= class_name %> < <%= parent_class_name.classify %>
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros

  # followed by association macros
<% attributes.select(&:reference?).each do |attribute| -%>
  belongs_to :<%= attribute.name %><%= ', polymorphic: true' if attribute.polymorphic? %><%= ', required: true' if attribute.required? %>
<% end -%>
<% attributes.select(&:token?).each do |attribute| -%>
  has_secure_token<% if attribute.name != "token" %> :<%= attribute.name %><% end %>
<% end -%>
  # and validation macros

  # next we have callbacks

  # other macros (like devise's) should be placed after the callbacks
<% if attributes.any?(&:password_digest?) -%>
  has_secure_password

<% end -%>
   # finally, scopes
end
<% end -%>
