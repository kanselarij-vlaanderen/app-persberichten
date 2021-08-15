alias Acl.Accessibility.Always, as: AlwaysAccessible
alias Acl.Accessibility.ByQuery, as: AccessByQuery
alias Acl.GraphSpec.Constraint.Resource, as: ResourceConstraint
alias Acl.GraphSpec, as: GraphSpec
alias Acl.GroupSpec, as: GroupSpec
alias Acl.GroupSpec.GraphCleanup, as: GraphCleanup

defmodule Acl.UserGroups.Config do

  defp access_by_group() do
    # Current query assumes user belongs to only one group.
    # If multiple groups must be allowed, the active group must be attached
    # to the user session on login and this group must be selected in the SPARQL query.
    %AccessByQuery{
      vars: ["group_id"],
      query: "PREFIX session: <http://mu.semte.ch/vocabularies/session/>
              PREFIX foaf: <http://xmlns.com/foaf/0.1/>
              PREFIX mu: <http://mu.semte.ch/vocabularies/core/>
              SELECT ?group_id WHERE {
                <SESSION_ID> session:account / ^foaf:account / ^foaf:member / mu:uuid ?group_id .
              } LIMIT 1"
    }
  end

  defp codelists_resource_types() do
    [
      "http://mu.semte.ch/vocabularies/ext/ContactStatus",
      "http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#PublicationChannel",
      "http://mu.semte.ch/vocabularies/ext/Thema",
      "http://www.w3.org/2006/vcard/ns#Organization",
      "http://kanselarij.vo.data.gift/core/Beleidsveld",
      "http://kanselarij.vo.data.gift/core/Beleidsdomein",
    ]
  end

  defp authentication_resource_types() do
    [
      "http://xmlns.com/foaf/0.1/Person",
      "http://xmlns.com/foaf/0.1/OnlineAccount",
      "http://xmlns.com/foaf/0.1/Group"
    ]
  end

  defp press_releases_resource_types() do
    [
      "http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#Contact",
      "http://www.w3.org/2006/vcard/ns#Cell",
      "http://www.w3.org/2006/vcard/ns#Voice",
      "http://www.w3.org/2006/vcard/ns#Email",
      "http://purl.org/spar/fabio/PressRelease",
      "http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#PublicationEvent",
      "http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#FileDataObject",
      "http://mu.semte.ch/vocabularies/ext/CollaborationActivity",
      "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#ContactList",
      "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#Contact",
    ]
  end

  defp email_resource_types() do
    [
      # "http://www.semanticdesktop.org/ontologies/2007/03/22/nmo#Mailbox",
      # "http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#Folder",
      "http://www.semanticdesktop.org/ontologies/2007/03/22/nmo#Email",
      # "http://www.semanticdesktop.org/ontologies/2007/03/22/nmo#MessageHeader",
    ]
  end

  def user_groups do
    # These elements are walked from top to bottom.  Each of them may
    # alter the quads to which the current query applies.  Quads are
    # represented in three sections: current_source_quads,
    # removed_source_quads, new_quads.  The quads may be calculated in
    # many ways.  The useage of a GroupSpec and GraphCleanup are
    # common.
    [
      # PUBLIC
      %GroupSpec{
        name: "public",
        useage: [:read],
        access: %AlwaysAccessible{},
        graphs: [
          %GraphSpec{
            graph: "http://mu.semte.ch/graphs/public",
            constraint: %ResourceConstraint{
              resource_types: [
                codelists_resource_types() ++
                authentication_resource_types()
              ]
            }
          }
        ]
      },

      # PER ORGANIZATION / CABINET
      %GroupSpec{
        name: "organization",
        useage: [:read, :write, :read_for_write],
        access: access_by_group(),
        graphs: [
          %GraphSpec{
            graph: "http://mu.semte.ch/graphs/organizations/",
            constraint: %ResourceConstraint{
              resource_types: press_releases_resource_types()
            }
          },
          %GraphSpec{
            graph: "http://mu.semte.ch/graphs/system/email",
            constraint: %ResourceConstraint{
              resource_types: email_resource_types()
            }
          },
        ]
      },

      # CLEANUP
      %GraphCleanup{
        originating_graph: "http://mu.semte.ch/application",
        useage: [:write],
        name: "clean"
      }
    ]
  end
end
