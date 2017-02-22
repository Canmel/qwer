require "qwer/version"
require 'qwer/translater'
require 'kaminari/helpers/helper_methods'
require 'kaminari/helpers/tags'
require 'kaminari/helpers/paginator'

module Qwer
  class Tmodel

    # 初始化
    # page_size:  单页记录数
    # page:       当前页数
    # model:      当前业务model
    def initialize(model, query, page_size, page)
      @model = model
      @query = query
      @page_size = page_size
      @page = page
    end

    # 查询项创建
    # params:   对表单的设置
    #   action:   表单action地址 | 必须
    #   charset:  设置字符集 | 默认值　UTF-8　| 可选
    #   new:      设置【新增】地址　| 可选

    # data:     要查询的内容
    # args :    其他参数
    def table_seach(params, data,*args)
      html_str = Translater.new.table_search(params, @query, data, @model)
      html_str.html_safe
    end

    # 数据表创建
    # table_head:   表头数据
    # datas:        数据
    # dname:        数据名称
    # args:         其他参数
    def table_data(table_head, opt, datas, *args)
      html_str = Translater.new.table_data(table_head, @model, opt, datas, *args)
      html_str.html_safe
    end

    # 分页
    # 使用kaminary分页
    # datas   查询的数据
    # def pager datas, **options
    # paginate_class = Kaminari::Helpers::Paginator
    #
    # options[:total_pages] = datas.total_pages
    # options.reverse_merge! current_page: datas.current_page, per_page: datas.limit_value, remote: false
    #
    #
    # paginator = paginate_class.new self, options
    # p "=========================1=="
    # p paginator.to_s
    # p "=========================2=="
    # html_str = "共#{datas.total_count}条 #{datas.total_pages}页#{paginate datas}"
    # html_str = Translater.new.pager(datas)
    # html_str.html_safe
    # end
  end
end