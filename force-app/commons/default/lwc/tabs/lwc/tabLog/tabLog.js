import { LightningElement, track, wire } from 'lwc';
import { subscribe, unsubscribe, APPLICATION_SCOPE, MessageContext } from 'lightning/messageService';
import RECORDS_MESSAGE from '@salesforce/messageChannel/RefreshRecords__c';
// Apex Methods
import getTotalRecords from '@salesforce/apex/LogController.getTotalRecords';
import getRecords from '@salesforce/apex/LogController.getRecordInfos';

const columns = [
    { label: 'Log Id', fieldName: 'recordUrl', type: 'url', typeAttributes: { label: { fieldName: 'logId' } } },
    { label: 'Created Date', fieldName: 'createdDate', type: 'date', displayReadOnlyIcon: true },
    { label: 'Owner', fieldName: 'ownerName', type: 'text', displayReadOnlyIcon: true },
    { label: 'Level', fieldName: 'level', type: 'text', displayReadOnlyIcon: true },
    { label: 'Type', fieldName: 'type', type: 'text', displayReadOnlyIcon: true },
    { label: 'Feature', fieldName: 'feature', type: 'text', displayReadOnlyIcon: true },
    { label: 'Service', fieldName: 'service', type: 'text', displayReadOnlyIcon: true },
    { label: 'Description', fieldName: 'description', type: 'text', displayReadOnlyIcon: true }
];

export default class TabLog extends LightningElement {
    @track isLoading = false;
    @track enableInfiniteLoading = true;
    @track records = [];
    columns = columns;
    defaultSortDirection = 'asc';
    enableNewRecord = false;
    error;
    iconUrl = '/img/icon/t4v35/custom/custom24_120.png';
    rowLimit = 25;
    rowOffSet = 0;
    sortDirection = 'asc';
    sortedBy;
    totalNumberOfRows = 0;

    label = {
        labelLogs: 'Logs'
    };

    @wire(MessageContext)
    messageContext;

    get filterTotalParams() {
        return {};
    }

    get filterParams() {
        return { limitSize: this.rowLimit, offsetSize: this.rowOffSet };
    }

    async loadData() {
        await getTotalRecords({ param: this.filterTotalParams }).then((response) => {
            this.totalNumberOfRows = response;
        });

        await getRecords({ param: this.filterParams })
            .then((result) => {
                // Appends new data to the end of the table
                const currentData = this.records;
                const newData = currentData.concat(result);
                this.records = newData;
                if (result.length >= this.totalNumberOfRows) {
                    this.enableInfiniteLoading = false;
                }
                this.error = undefined;
            })
            .catch((error) => {
                console.error('Error in getting records', error);
                this.records = [];
            });
    }

    resetAndLoad() {
        this.records.length = 0;
        this.loadData();
    }

    loadMoreData() {
        if (this.records.length < this.totalNumberOfRows) {
            this.isLoading = true;

            this.rowOffSet = this.rowOffSet + this.rowLimit;
            this.loadData().then(() => {
                this.isLoading = false;
            });
        }
    }

    subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                RECORDS_MESSAGE,
                (message) => this.handleMessage(message),
                {
                    scope: APPLICATION_SCOPE
                }
            );
        }
    }

    handleMessage(message) {
        if (message.action === 'refresh-log') {
            this.resetAndLoad();
        }
    }

    unsubscribeToMessageChannel() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }

    renderedCallback() {
        document.title = 'Logs | Salesforce';
    }

    connectedCallback() {
        this.loadData();
        this.subscribeToMessageChannel();
    }

    disconnectedCallback() {
        this.unsubscribeToMessageChannel();
    }
}
