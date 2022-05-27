import { LightningElement ,wire,track} from 'lwc';
import getAllDashboards from '@salesforce/apex/LWC01_DashboardListController.getAllDashboards'
// https://salesforce.stackexchange.com/questions/257065/hyperlink-record-name-lwc-datatable

export default class Lwc01DashboardList extends LightningElement {
    @track columns = [
        {
            label: 'Dashboard',
            fieldName: 'dashboardNameUrl',
            type: 'url',
            typeAttributes: {label: { fieldName: 'dashboardName' }, 
            target: '_blank'},
            cellAttributes: { 
                iconName: 'standard:dashboard' 
            }
        }
    ];

    @track error;
    @track dashboardLists = [];

    @wire(getAllDashboards)
    wiredOpps({error,data}) {
        if (data) {
            this.dashboardLists = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.dashboardLists = undefined;
        }
    }
}