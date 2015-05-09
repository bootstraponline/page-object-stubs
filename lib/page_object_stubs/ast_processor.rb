module PageObjectStubs

  class ProcessPageObjects < Parser::AST::Processor

    attr_reader :name_type_pairs

    def initialize
      @name_type_pairs = []
      super
    end

    # page-object/lib/page-object/elements/*.rb plus page_url
    @@valid_elements = %w[area audio button canvas check_box div element file_field form heading hidden_field image
label link list_item media option ordered_list paragraph radio_button select_list span table
table_cell table_row text_area text_field unordered_list video] + %w[page_url]

    def is_valid child
      # child may be a symbol or a string
      @@valid_elements.include?(child.to_s)
    end

    def _print_children children_array
      # `def on_send` receives AST::Node send
      # the children array of that node is sent to _print_children
      # -> symbol :page_url
      # inside print children, the element type is found (page_url)
      # -> AST::Node str/symbol
      # once we know the type, we look for an AST::Node that contains the element name

      pair = []

      find_element_name = false
      element_name      = nil # symbol or string
      children_array.each do |child|
        if find_element_name && child.is_a?(AST::Node)
          first = child.children.first
          if first.class == Symbol || first.class == String
            element_name = first.to_s
            # puts "element_name: #{element_name}"
            pair << element_name
            break
          end
        end

        if is_valid child
          # puts "element_type: #{child}"
          pair << child.to_s # element_type
          find_element_name = true
        end unless find_element_name
      end

      @name_type_pairs << pair if pair.length == 2
    end

    def generate_send node
      c = node.children

      return unless c
      _print_children c
      # node.type is send
      # the rest of the data is in the children.
    end

    def on_send node
      generate_send node
      super
    end
  end
end
