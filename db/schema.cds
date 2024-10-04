using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';

namespace sap.capire.incidents;

/**
* Incidents created by Customers.
*/
entity Incidents : cuid, managed {
    customer     : Association to Customers;
    title        : String @title: 'Title';
    urgency      : Association to Urgency default 'M';
    status       : Association to Status default 'N';
    conversation : Composition of many {
                       key ID        : UUID;
                           timestamp : type of managed : createdAt;
                           author    : type of managed : createdBy;
                           message   : String;
                   };
}

// /**
// * Customers entitled to create support Incidents.
// */
// entity Customers : managed {
//     key ID           : String;
//         firstName    : String;
//         lastName     : String;
//         name         : String = firstName || ' ' || lastName;
//         email        : EMailAddress;
//         phone        : PhoneNumber;
//         incidents    : Association to many Incidents
//                            on incidents.customer = $self;
//         creditCardNo : String(16) @assert.format: '^[1-9]\d{15}$';
//         addresses    : Composition of many Addresses
//                            on addresses.customer = $self;
// }

// entity Addresses : cuid, managed {
//     customer      : Association to Customers;
//     city          : String;
//     postCode      : String;
//     streetAddress : String;
// }

using {API_BUSINESS_PARTNER as bp} from '../srv/external/API_BUSINESS_PARTNER';

entity Customers as
    projection on bp.A_BusinessPartner {
        key BusinessPartner,
            BusinessPartnerFullName  as FullName,
            BusinessPartnerIsBlocked as IsBlocked,
            incidents : Association to many Incidents on incidents.customer = $self
    };

entity Status : CodeList {
    key code        : String enum {
            new        = 'N';
            assigned   = 'A';
            in_process = 'I';
            on_hold    = 'H';
            resolved   = 'R';
            closed     = 'C';
        };
        criticality : Integer;
}

entity Urgency : CodeList {
    key code : String enum {
            high   = 'H';
            medium = 'M';
            low    = 'L';
        };
}

type EMailAddress : String;
type PhoneNumber  : String;
