# Automated Lead Conversion for Acme, Inc.

## Overview
This Salesforce DX project aims to automate the lead conversion process for Acme, Inc. It integrates Marketo for lead data collection and Clearbit for lead enrichment. The solution automatically converts Salesforce Lead records into Account and Contact records, ensuring no duplicates are created.

## Features

- **Marketo Integration**: Syncs new Person records to Salesforce as Lead records.
- **Clearbit Enrichment**: Enriches Lead records with additional data in real-time.
- **Automated Conversion**: Converts enriched Lead records into Account and Contact records.
- **No Duplicates**: Ensures that no duplicate Accounts or Contacts are created during the conversion process.

## Prerequisites

- Salesforce Developer Org
- Salesforce CLI
- Marketo and Clearbit accounts

## Installation Steps

1. **Clone the Repository**:  
   ```
   git clone https://github.com/maxsorto/SFDX-Lead-Conversion-Solution
   ```

2. **Navigate to the Project Directory**:  
   ```
   cd SFDX-Lead-Conversion-Solution
   ```

3. **Authenticate with your Dev Org**:  
   ```
   sfdx auth:web:login -d -a MyDevOrg
   ```

4. **Deploy to Dev Org**:  
   ```
   sfdx force:source:deploy -p force-app -u MyDevOrg
   ```

## Custom Objects and Fields

- `Property__c`: Custom object to store known domain names for accounts.
  - `DomainName__c`: Text field to store the domain name.
  - `Account__c`: Master-detail field to relate to the Account object.

- `Lead`:
  - `cbit__ClearbitReady__c`: Checkbox to indicate Clearbit enrichment.
  - `cbit__Clearbit__c`: Lookup field to the Clearbit custom object.

- `Account`:
  - `FlagCompanyId__c`: Text field to store the unique identifier from Clearbit.

## Usage

Once installed, the system will automatically convert new Lead records created by Marketo into Account and Contact records in Salesforce, based on the criteria specified.

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

---

Feel free to add or modify any sections as you see fit for your project.
