const cds = require('@sap/cds')

module.exports = cds.service.impl(async function() {
  const bupa = await cds.connect.to('API_BUSINESS_PARTNER');

  this.on('READ', 'Customers', req => {
      return bupa.run(req.query);
  });

});


// class ProcessorService extends cds.ApplicationService {
//   /** Registering custom event handlers */
//   init() {
//     this.before("UPDATE", "Incidents", (req) => this.onUpdate(req));
//     this.before("CREATE", "Incidents", (req) => this.changeUrgencyDueToSubject(req.data));

//     return super.init();
//   }

//   on() {
//     this.on('READ', 'Customers', (req) => this.read('Customers'));
//   }

//   changeUrgencyDueToSubject(data) {
//     if (data) {
//       const incidents = Array.isArray(data) ? data : [data];
//       incidents.forEach((incident) => {
//         if (incident.title?.toLowerCase().includes("urgent")) {
//           incident.urgency = { code: "H", descr: "High" };
//         }
//       });
//     }
//   }

//   /** Custom Validation */
//   async onUpdate (req) {
//     const { status_code } = await SELECT.one(req.subject, i => i.status_code).where({ID: req.data.ID})
//     if (status_code === 'C')
//       return req.reject(`Can't modify a closed incident`)
//   }

//   async readBupa (req) {
//     const bupa = await cds.connect.to('API_BUSINESS_PARTNER');
    
//     return bupa.run(req.query);
//   }

// }
// module.exports = { ProcessorService }
