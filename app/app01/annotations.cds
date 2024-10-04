using ProcessorService as service from '../../srv/services';
using from '../../db/schema';

annotate service.Incidents with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Customer',
                Value : customer_BusinessPartner,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>Overview}',
            ID : 'Overview',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    ID : 'GeneratedFacet1',
                    Label : 'General Information',
                    Target : '@UI.FieldGroup#GeneratedGroup',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Details',
                    ID : 'Details',
                    Target : '@UI.FieldGroup#Details',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Conversation}',
            ID : 'Conversation',
            Target : 'conversation/@UI.LineItem#Conversation',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : title,
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : customer_BusinessPartner,
            Label : '{i18n>Customer}',
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : status.descr,
            Label : '{i18n>Status}',
            Criticality : status.criticality,
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : urgency.descr,
            Label : '{i18n>Urgency}',
            ![@UI.Importance] : #Medium,
        },
    ],
    UI.SelectionFields : [
        status_code,
        urgency_code,
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : title,
        },
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : customer_BusinessPartner,
        },
        TypeImageUrl : 'sap-icon://alert',
    },
    UI.FieldGroup #Details : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : status_code,
            },
            {
                $Type : 'UI.DataField',
                Value : urgency_code,
            },
        ],
    },
);

annotate service.Incidents with {
    customer @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Customers',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : customer_BusinessPartner,
                    ValueListProperty : 'BusinessPartner',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'FullName',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'IsBlocked',
                },
            ],
        },
        Common.Text : customer.FullName,
        Common.ValueListWithFixedValues : false,
    )
};

annotate service.Incidents with {
    status @(
        Common.Label : '{i18n>Status}',
        Common.ValueListWithFixedValues : true,
        Common.Text : status.descr,
    )
};

annotate service.Incidents with {
    urgency @(
        Common.Label : '{i18n>Urgency}',
        Common.ValueListWithFixedValues : true,
        Common.Text : urgency.descr,
    )
};

annotate service.Urgency with {
    code @Common.Text : descr
};

annotate service.Status with {
    code @Common.Text : descr
};

annotate service.Customers with {
    FullName @Common.Text : BusinessPartner
};

annotate service.Customers with {
    BusinessPartner @Common.Text : FullName
};

annotate service.Incidents.conversation with @(
    UI.LineItem #Conversation : [
        {
            $Type : 'UI.DataField',
            Value : author,
            Label : 'Author',
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : message,
            Label : '{i18n>Message}',
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : timestamp,
            Label : '{i18n>Date}',
            ![@UI.Importance] : #Medium,
        },
    ]
);

