#
# Copyright 2012, Asbjorn Kjaer
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/knife'
require 'chef/search/query'

module BulkRunlistEdit
   class BreAdd < Chef::Knife
      banner "knife bre add SEARCH RUNLIST_ITEMS"

      option :preflight,
             :short => '-P',
             :long => '--preflight',
             :boolean => true,
             :description => 'Just show the changes, don\'t commit'

      option :after,
             :short => '-a ITEM',
             :long => '--after ITEM',
             :description => 'Place the ENTRY after ITEM in the run list'

      option :changes,
             :short => '-C',
             :long => '--show-changes',
             :boolean => true,
             :description => 'Output the modified run list on STDOUT'

      def run
         if name_args.size < 2
            ui.fatal "Invalid number of arguments, must specify two arguments"
            show_usage
            exit 1
         end

         nodesearch = Chef::Search::Query.new
         query = name_args.shift
         runlist_items = name_args

         if config[:preflight]
            ui.warn "Only showing changes, not committing"
         end

         nodesearch.search('node', query) do |node|
            if config[:after]
               nlist = []
               node.run_list.each do |entry|
                  nlist << entry
                  if entry == config[:after]
                     runlist_items.each { |e| nlist << e }
                  end
               end
               node.run_list.reset!(nlist)
            else
               runlist_items.each { |e| node.run_list << e }
            end

            # Only show output if we are in explain or preflight mode
            if config[:changes] or config[:preflight]
               ui.msg "#{ui.color(node.name, :cyan)}: #{node.run_list}"
            end

            unless config[:preflight]
               node.save
               ui.msg "#{ui.color(node.name, :cyan)}: Run list saved"
            end
         end
      end
   end

   class BreRemove < Chef::Knife
      banner "knife bre remove SEARCH RUNLIST_ITEMS"

      option :preflight,
             :short => '-P',
             :long => '--preflight',
             :boolean => true,
             :description => 'Dont do anything, just show the nodes that would be changed'

      option :changes,
             :short => '-C',
             :long => '--show-changes',
             :boolean => true,
             :description => 'Output the modified run list on STDOUT'

      def run
         unless name_args.size >= 2
            ui.fatal('Not enough arguments specified')
            show_usage
            exit 1
         end

         nodesearch = Chef::Search::Query.new
         query = name_args.shift
         runlist_items = name_args

         if config[:preflight]
            ui.warn "Only showing changes, not committing"
         end

         nodesearch.search('node', query) do |node|
            runlist_items.each do |rli|
               node.run_list.remove(rli)
            end

            # Only show output if we are in explain or preflight mode
            if config[:changes] or config[:preflight]
               ui.msg "#{ui.color(node.name, :cyan)}: #{node.run_list}"
            end

            unless config[:preflight]
               node.save
               ui.msg "#{ui.color(node.name, :cyan)}: Run list saved"
            end
         end
      end
   end
end
