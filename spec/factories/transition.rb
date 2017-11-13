# FactoryBot.define do
#   # TRANSITIONS = %w(designed assembled painted tested)
#   # FIRST_STATE = TRANSITIONS.first
#
#   factory :transition do
#     # TRANSITIONS = %w(designed assembled painted tested)
#     # current_transitions = transitions
#     # original = current_transitions.sample
#     # transitions(current_transitions - [original])
#
#     # transient do
#     #   from  #%w(designed assembled painted tested)
#     #   to
#     # end
#
#     # sequence(:from) { transitions.first }
#     # sequence(:from) { TRANSITIONS.first }
#     # sequence(:to) { TRANSITIONS.delete_if { |e| e == from }.first || FIRST_STATE }
#     sequence(:from) { from }
#     sequence(:to) { to }
#     created_at { DateTime.now }
#
#   end
# end
