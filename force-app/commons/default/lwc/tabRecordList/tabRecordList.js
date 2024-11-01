import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class TabRecordList extends NavigationMixin(LightningElement) {
    @api records = [];

    _totalRecords = 0;
    @api
    get totalRecords() {
        return this._totalRecords > 5000 ? '5000+' : this._totalRecords;
    }
    set totalRecords(value) {
        this._totalRecords = value;
    }

    @api columns = [];
    @api newRecordType = '';
    @api tabName = '';
    @api iconUrl;
    @api isLoading;
    @api enableInfiniteLoading;
    @api enableNewRecord;
    showFilters = false;

    label = {
        labelAll: 'All',
        labelNew: 'New',
        labelItems: 'Items',
        labelUpdated_Few_Seconds_Ago: 'Updated few seconds ago',
        labelSorted_by_Latest_Updated: 'Sorted by Latest Updated',
        labelSearch: 'Search',
        labelRefresh: 'Refresh',
        labelFilter: 'Filter'
    };

    filters;
    @api get filterProperties() {
        return this.filters;
    }
    set filterProperties(value) {
        this.filters = value?.map((item) => ({ ...item }));
    }

    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    sortedBy;

    handleNewRecordPopup() {
        this.dispatchEvent(new CustomEvent('new'));
    }

    sortBy(field, reverse, primer) {
        const key = primer
            ? function (x) {
                  return primer(x[field]);
              }
            : function (x) {
                  return x[field];
              };

        return function (a, b) {
            a = key(a);
            b = key(b);
            return reverse * ((a > b) - (b > a));
        };
    }

    onHandleSort(event) {
        const { fieldName: sortedBy, sortDirection } = event.detail;
        const cloneData = [...this.records];

        cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
        // eslint-disable-next-line @lwc/lwc/no-api-reassignments
        this.records = cloneData;
        this.sortDirection = sortDirection;
        this.sortedBy = sortedBy;
    }

    loadMoreData() {
        this.dispatchEvent(new CustomEvent('loadmore'));
    }

    get searchPlaceholder() {
        return `${this.label.labelSearch} ${this.tabName}...`;
    }

    // filters
    get hasFilters() {
        return this.filters && this.filters.length > 0;
    }

    handleShowFilters() {
        this.showFilters = !this.showFilters;
    }

    handleSearch() {
        this.dispatchEvent(
            new CustomEvent('search', {
                detail: this.filters
            })
        );
    }

    handleFilterChange(event) {
        this.filters.find((e) => e.name === event.detail.name).value = event.detail.value;
    }

    handleFilterReset() {
        this.filters = this.filters.map((obj) => {
            return { ...obj, value: '' };
        });
        this.handleSearch();
    }

    handleFilterClick(event) {
        if (event.detail === 'contact') {
            this.dispatchEvent(
                new CustomEvent('filterclick', {
                    detail: event.detail
                })
            );
        }
    }

    showNotification(message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: message,
                variant: variant
            })
        );
    }
}
