<%- Team.all.each do |team| -%>
## <%= team.name %>

### <%= progress(team) %>

<TODO: ここにグラフを出力して貼ってね>
  <%- topics = topics(team) -%>
  <%- if topics.present? -%>
### 先週のトピック

    <% topics.each do |topic| -%>
- <%= topic.content %>

    <%- end -%>
  <%- end -%>
<%- end -%>
