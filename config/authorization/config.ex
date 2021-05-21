alias Acl.Accessibility.Always, as: AlwaysAccessible
alias Acl.GraphSpec.Constraint.Resource, as: ResourceConstraint
alias Acl.GraphSpec, as: GraphSpec
alias Acl.GroupSpec, as: GroupSpec
alias Acl.GroupSpec.GraphCleanup, as: GraphCleanup

defmodule Acl.UserGroups.Config do
  def user_groups do
    # These elements are walked from top to bottom.  Each of them may
    # alter the quads to which the current query applies.  Quads are
    # represented in three sections: current_source_quads,
    # removed_source_quads, new_quads.  The quads may be calculated in
    # many ways.  The useage of a GroupSpec and GraphCleanup are
    # common.
    [
      # // PUBLIC
      %GroupSpec{
        name: "public",
        useage: [:read, :write, :read_for_write],
        access: %AlwaysAccessible{},
        graphs: [%GraphSpec{
          graph: "http://mu.semte.ch/graphs/public",
          constraint: %ResourceConstraint{
            resource_types: [
              "http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#Contact",
              "http://www.w3.org/2006/vcard/ns#Cell",
              "http://www.w3.org/2006/vcard/ns#Voice",
              "http://www.w3.org/2006/vcard/ns#Email",
              "http://purl.org/spar/fabio/PressRelease",
              "http://mu.semte.ch/vocabularies/ext/CollaborationActivity"
            ]
          }
        }]
      },

      # // CLEANUP
      #
      %GraphCleanup{
        originating_graph: "http://mu.semte.ch/application",
        useage: [:write],
        name: "clean"
      }
    ]
  end
end
