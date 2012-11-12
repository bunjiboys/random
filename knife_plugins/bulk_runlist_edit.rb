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
             :description => 'Dont do anything, just show the nodes that would be changed'

      def run
         ui.highline
         if name_args.size != 2
            ui.fatal "Invalid number of arguments, must specify two arguments"
            show_usage
            exit 1
         end

         nodesearch = Chef::Search::Query.new
         query = name_args.shift
         runlist_items = name_args.shift

         if config[:preflight]
            ui.warn "Only showing changes, not committing"
         end

         nodesearch.search('node', query) do |node|
            runlist_items.split(',').each do |rli|
               node.run_list << rli
            end

            ui.msg "#{ui.color(node.name, :cyan)}: #{node.run_list}"
            unless config[:preflight]
               node.save
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

      def run
         ui.highline
         unless name_args.size >= 2
            ui.fatal('Not enough arguments specified')
            show_usage
            exit 1
         end

         nodesearch = Chef::Search::Query.new
         query = name_args.first
         runlist_items = name_args[1 .. -1]

         if config[:preflight]
            ui.warn "Only showing changes, not committing"
         end

         nodesearch.search('node', query) do |node|
            runlist_items.each do |rli|
               node.run_list.remove(rli)
            end

            ui.msg "#{ui.color(node.name, :cyan)}: #{node.run_list}"
            unless config[:preflight]
               node.save
            end
         end
      end
   end
end
