import '@/styles/globals.css'
import { MoralisProvider } from 'react-moralis'
import { NotificationProvider } from 'web3uikit'

function Myapp({ Component, pageProps }) {
  return (
    <MoralisProvider initializeOnMount={false}>
      <NotificationProvider>
        <Component {...pageProps} />
      </NotificationProvider>
    </MoralisProvider>
  )
}

export default Myapp