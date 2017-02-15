module Qwer
  class Translater
    def self.table_search(form_params, data_params, model)
      html_str = "<form class='#{form_params[:form_class] ||= 'pjax-form'}' id='' action='#{form_params[:action] ||= model}' accept-charset='#{form_params[:charset] ||= 'UTF-8' }' method='#{form_params[:method] ||= 'get'}'>"
      html_str << "<input name='utf8' type='hidden' value='✓'>"
      data_params.reject { |key, value| html_str << "<div class='form-group'><label class='control-label'>#{value}：</label><input class='form-control' type='search' name='#{key}' id='q_#{key}'></div>" }
      html_str << "<a class='btn btn-success green' href='#{form_params[:new]}'>新增</a>" if form_params[:new]
      html_str << "<button type='submit' class='btn btn-info' data-toggle='modal' data-target='#search_model'>查询</button>"
      html_str << "</form>"
    end

    def self.table_data(table_head, dname, opt, datas, *args)
      html_str = "<table class='table table-striped table-hover' id='editable-sample'><thead><tr><th>#</th>"
      table_head.reject { |key, value| html_str << "<th>#{value}</th>" }
      html_str << "<th>操作</th></tr></thead><tbody>"
      datas.each_with_index do |data, index|
        tr_html = "<tr>"
        tr_html << "<td>#{sequence index}</td>"
        # 数据内容
        table_head.reject { |key, value| tr_html << "<td>#{send_keys data, key}</td>" }
        # 操作
        tr_html << "<td>"
        opt.reject { |key, value| tr_html << opt_btns(key, value, dname, data) }
        tr_html << "</td>"
        tr_html << "</tr>"
        html_str << tr_html
      end
      html_str << "</tbody></table>"
    end

    private

    def self.sequence(index)
      (@page.to_i - 1) * @page_size.to_i + index + 1
    end

    def self.edit?(opt)
      opt == "edit"

    end

    def self.delete?(opt)
      opt == "del"
    end

    def self.send_keys data, key
      keys = key.to_s.split '.'
      keys.each do |item|
        data = data.send item if data.present?
      end
      data
    end

    def self.opt_btns key, value, dname, data
      if edit? key.to_s
        return "<a class='#{value[:css] ||= 'label label-success'}' href='/#{dname}/#{data.id.to_s}/edit'>#{value[:name] ||= '编辑'}</a>"
      elsif delete? key.to_s
        return "<a data-confirm='确认要删除这条数据吗?' class='#{value[:css] ||= 'label label-danger'}' rel='nofollow' data-method='delete' href='/#{dname}/#{data.id.to_s}'>#{ value[:name] ||= '删除'}</a>"
      else
        return value.gsub('??', '??'=>data.id) if value["??"].present?
      end
    end
  end
end