require 'qwer/layout_helper'

module Qwer
  class Translater
    DEFAULT_COL_NUM = 3               #　查询 table 默认列数
    INIT_CONTER = 1                   #  计数器从１开始

    def table_search(form_params, query, data_params, model)
      col_num = form_params[:col_num] ||= DEFAULT_COL_NUM
      conter ||= INIT_CONTER
      html_str = "<form class='#{form_params[:form_class] ||= 'pjax-form'}' id='company_search' action='#{form_params[:action] ||= model}' accept-charset='#{form_params[:charset] ||= 'UTF-8' }' method='#{form_params[:method] ||= 'get'}'>"
      html_str << "<input name='utf8' type='hidden' value='✓'>"
      html_str << Qwer::Helper::HelperMethod.new(col_num, query, data_params.size, model).form_render(data_params, form_params).to_s
      html_str << "</form>"
    end

    def table_data(table_head, dname, opt, datas, *args)
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

    # 设置数据表格序号
    def sequence(index)
      (@page.to_i - 1) * @page_size.to_i + index + 1
    end

    # 判断是否是编辑方法
    def edit?(opt)
      opt == "edit"

    end

    # 判断是否是删除方法
    def delete?(opt)
      opt == "del"
    end

    # 获取给定的params的key的值
    def send_keys data, key
      keys = key.to_s.split '.'
      keys.inject(data){|result, item| result.send item if result.present? }
    end

    # 操作列
    def opt_btns key, value, dname, data
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