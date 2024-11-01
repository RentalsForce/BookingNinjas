import { LightningElement, api } from 'lwc';

export default class TabRecordListFilters extends LightningElement {
    label = {
        labelReset_All: 'Reset All',
        labelReset_All_Filters: 'Reset All Filters',
        labelSearch: 'Search'
    };

    @api filters = [];

    handleFilterChange(event) {
        const inputName = event.currentTarget.name;
        const inputValue = event.detail.value;

        this.dispatchEvent(
            new CustomEvent('input', {
                detail: {
                    name: inputName,
                    value: inputValue
                }
            })
        );
    }

    handleSearch() {
        this.dispatchEvent(new CustomEvent('search'));
    }

    handleResetAllFilters() {
        this.template.querySelectorAll('lightning-input').forEach((e) => {
            e.value = '';
        });
        this.template.querySelectorAll('lightning-combobox').forEach((e) => {
            e.value = '';
        });
        this.dispatchEvent(new CustomEvent('reset'));
    }

    handleFilterClick(event) {
        this.dispatchEvent(
            new CustomEvent('click', {
                detail: event.currentTarget.name
            })
        );
    }
}
