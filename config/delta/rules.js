export default [
    {
        match: {
            // match everything
        },
        callback: {
            url: 'http://resource/.mu/delta',
            method: 'POST',
        },
        options: {
            resourceFormat: 'v0.0.1',
            gracePeriod: 250,
            ignoreFromSelf: true,
        },
    },
    {
        match: {
            predicate: {
                type: 'uri',
                value: 'http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#publishedStartDateTime', // ebucore:publishedStartDateTime
            },
        },
        callback: {
            url: 'http://publication-tasks-generator/delta',
            method: 'POST',
        },
        options: {
            resourceFormat: 'v0.0.1',
            gracePeriod: 250,
            ignoreFromSelf: true,
        },
    },
    {
        match: {
            predicate: {
                type: 'uri',
                value: 'http://www.w3.org/ns/adms#status',
            },
            object: {
                type: 'uri',
                value: 'http://themis.vlaanderen.be/id/concept/publication-task-status/not-started',
            },
        },
        callback: {
            url: 'http://email-publication/delta',
            method: 'POST',
        },
        options: {
            resourceFormat: 'v0.0.1',
            gracePeriod: 250,
            ignoreFromSelf: true,
        },
    },
    {
        match: {
            predicate: {
                type: 'uri',
                value: 'http://www.w3.org/ns/adms#status',
            },
            object: {
                type: 'uri',
                value: 'http://themis.vlaanderen.be/id/concept/publication-task-status/not-started',
            },
        },
        callback: {
            url: 'http://belga-publication/delta',
            method: 'POST',
        },
        options: {
            resourceFormat: 'v0.0.1',
            gracePeriod: 250,
            ignoreFromSelf: true,
        },
    },
    {
        match: {
            predicate: {
                type: 'uri',
                value: 'http://www.w3.org/ns/adms#status',
            },
            object: {
                type: 'uri',
                value: 'http://themis.vlaanderen.be/id/concept/publication-task-status/not-started',
            },
        },
        callback: {
            url: 'http://mailchimp-publication/delta',
            method: 'POST',
        },
        options: {
            resourceFormat: 'v0.0.1',
            gracePeriod: 250,
            ignoreFromSelf: true,
        },
    },
    {
        match: {
            predicate: {
                type: 'uri',
                value: 'http://www.w3.org/ns/adms#status'
            },
            object: {
                type: 'uri',
                value: 'http://themis.vlaanderen.be/id/concept/publication-task-status/not-started'
            },
        },
        callback: {
            url: 'http://api-publication/delta',
            method: 'POST'
        },
        options: {
            resourceFormat: 'v0.0.1',
            gracePeriod: 250,
            ignoreFromSelf: true
        },
    },
];
