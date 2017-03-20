import React from 'react';
import axios from 'axios';

class CustomerList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      customers:[]
    };
  }

  componentDidMount() {
      axios.get('/customers.json').then((resp)=>{
        console.log(resp);
        this.setState({
          customers:  resp.data
        });
      });
  }


  render() {
    const customersRows = this.state.customers.map((customer)=>{
        return (
          <li key={customer.id}>{customer.name}</li>
        )
    });

    return (
      <div>
        <ul>
          {customersRows}
        </ul>
      </div>
    );
  }

}

export default CustomerList;
