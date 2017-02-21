# coding: utf-8

module Qwer
  require "qwer/version"

  module Helper
    class HelperMethod
      MAX_LOOP_NUM = 10
      DEFAULT_COL_NUM = 3

      # 查询项布局初始化
      # col_num : table的列数
      # data_size : 查询项数量
      def initialize(col_num, data_size)
        @col_num = col_num
        @data_size = data_size
      end

      def form_render data_params, form_params
        html_str = ""
        # 适配单行是都能显示　先暂时定位３　以后做适配
        if data_params.size > DEFAULT_COL_NUM
          html_str << form_table_render(form_params, data_params)
        else

          data_params.reject { |key, value|
            if value.class.to_s.eql?('String')
              html_str << "<div><label class='control-label'>#{value}：</label><input class='form-control' type='search' name='#{key}' id='q_#{key}'></div>"
            else
              html_str << "<div><label class='control-label'>#{value[:name]}：</label>"
              if select? value
                html_str << add_selector(key, value)
              else
                html_str << "<input class='#{value[:css] ||= 'form-control'}' type='search' name='#{key}' id='q_#{key}'>"
              end
              html_str << "</div>"
            end

          }
          html_str << button_render(form_params)
        end
        html_str
      end

      private

      def add_selector key, value
        html_str = "<select class='form-control' name='#{key}' id='#{get_input_id key}'>"
        if value[:data].present?
          html_str << "<option value=''>全部</option>" if value[:data].include? 'all'
          value[:data].each do |item|
            html_str << "<option value='#{item[:k]}'>#{item[:v]}</option>" if item.class.to_s.eql? 'Hash'
          end
        end
        html_str << "</select>"
      end

      # 得到查询项，table
      def form_table_render form_param, data_params
        conter = 1
        total = 1
        html_str = "<table class='table text-left'>"
        data_params.reject { |key, value|
          html_str << "<tr>" if tr_start? conter
          html_str << "<td style='border: none'>"
          html_str << "<div class='form-group'>"
          if value.class.to_s.eql? 'String'
            html_str << "<label class='control-label'>#{value}：</label><input class='#{'form-control'}' type='search' name='#{key}' id='#{get_input_id key}'></div>"
          else
            html_str << "<label class='control-label'>#{value[:name]}：</label>"
            if select? value
              html_str << add_selector(key, value)
            else
              html_str << "<input class='#{value[:css] ||= 'form-control'}' type='search' name='#{key}' id='#{get_input_id key}'>"
            end
          end
          html_str << "</div>"

          html_str << "</td>"

          if !tr_end? conter
            # 一行tr 还没有结束 需要填补td
            html_str << add_td_or_blank_td(form_param, conter, total)
          end
          html_str << "</tr>" if tr_end? conter
          conter = 0 if tr_end? conter
          conter += 1
          total += 1
        }
        # 查询项 正好占满整行，需要另起一个tr，添加 button
        html_str << add_new_btn_tr(form_param)
        html_str << "</table>"
      end

      # 添加空td,或button td
      def add_td_or_blank_td form_params, counter, total
        html_str = ""
        return html_str if has_any_td? total
        # 循环添加td，直至填满tr,在最后添加button
        while true
          break if tr_end?(counter + 1) || counter > MAX_LOOP_NUM
          html_str << "<td style='border: none;'></td>"
          counter += 1
        end
        html_str << "<td style='border:none;text-align:center;'>"
        html_str << button_render(form_params)
        html_str << "</td>"
      end

      def button_render form_params
        html_str = "<a class='btn btn-success green' href='#{form_params[:new]}'>新增</a>" if form_params[:new]
        html_str << "<button type='submit' class='btn btn-info' data-toggle='modal' data-target='#search_model'>查询</button>"
      end

      # 单行tr 开始
      def tr_start? counter
        counter == 1
      end

      # 单行tr 结束
      def tr_end? counter
        counter == @col_num
      end

      # 有剩余td 没有添加
      def has_any_td? total
        total < @data_size
      end

      # 是否是下拉栏
      def select? value
        value[:type] == 'select'
      end

      def data? value
        value[:type] == 'date'
      end

      def data_time? value
        value[:type] == 'data_time'
      end

      def get_input_id key
        k = key.to_s
        k['['] = "_"
        k[']'] = ""
        k
      end

      # 添加一行新的tr(有必要的话)
      def add_new_btn_tr params
        html_str = ""
        result = @data_size % @col_num
        if result.zero?
          html_str << "<tr>"
          (@col_num-1).times{
            html_str << "<td style='border:none;'>"
            html_str << "</td>"
          }
          html_str << "<td style='border:none;text-align: center;'>"
          html_str << button_render(params)
          html_str << "</td>"
          html_str << "</tr>"
        end
        html_str
      end

    end
  end
end